import 'package:flutter/material.dart';
import 'package:flutter_todo/common/widget/common_app_bar.dart';
import 'package:flutter_todo/common/widget/common_text_field.dart';
import 'package:flutter_todo/route/route_constant.dart';
import 'package:flutter_todo/route/route_manager.dart';
import 'package:flutter_todo/style/app_colors.dart';
import 'package:flutter_todo/style/app_text_style.dart';
import 'package:flutter_todo/task/bloc/add_task_bloc.dart';
import 'package:flutter_todo/task/model/task.dart';
import 'package:flutter_todo/task/state/add_task_state.dart';
import 'package:flutter_todo/task/utils/task_validator.dart';
import 'package:flutter_todo/util/date_util.dart';
import 'package:rxdart/rxdart.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key, this.task, this.index}) : super(key: key);
  final Task? task;
  final int? index;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final AddTaskBloc addTaskBloc = AddTaskBloc();
  final _subscriptions = CompositeSubscription();

  @override
  void initState() {
    super.initState();
    _subscriptions.add(addTaskBloc.taskDueDate.listen((value) {
      addTaskBloc.taskDueDateController.text = DateUtil.formatDate(value, 'dd/MM/yyyy');
    }));

    if (widget.task != null) {
      addTaskBloc.taskDueDateController.text = widget.task?.timestamp.toString() ?? '';
      addTaskBloc.taskNameController.text = widget.task?.taskName ?? '';
      addTaskBloc.taskDescriptionController.text = widget.task?.taskDescription ?? '';
      addTaskBloc.taskName.add(addTaskBloc.taskNameController.text);
      addTaskBloc.taskDescription.add(addTaskBloc.taskDescriptionController.text);
      addTaskBloc.taskDueDate.add(widget.task?.timestamp ?? DateTime.now());
    }

    _subscriptions.add(addTaskBloc.addTaskState.listen((value) {
      if (value?.isCompleted() ?? false) {
        AppRouteManager.pushNamedAndRemoveUntil(RouteConstant.home, (route) => false);
      }
    }));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      addTaskBloc.taskDueDate.add(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'Add Task'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                CommonTextField(
                  labelText: 'Task name',
                  textEditingController: addTaskBloc.taskNameController,
                  onChanged: (value) {
                    addTaskBloc.taskName.add(value);
                  },
                  validator: (input) =>
                      TaskValidator().isValidTaskName(input) ? null : 'Please enter a valid task name.',
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  labelText: 'Description',
                  textEditingController: addTaskBloc.taskDescriptionController,
                  onChanged: (value) {
                    addTaskBloc.taskDescription.add(value);
                  },
                  maxLines: 5,
                  validator: (input) => TaskValidator().isValidTaskName(input)
                      ? null
                      : 'Please enter a valid task description.',
                ),
                const SizedBox(height: 16),
                StreamBuilder<DateTime>(
                    stream: addTaskBloc.taskDueDate,
                    builder: (context, snapshot) {
                      return CommonTextField(
                        textEditingController: addTaskBloc.taskDueDateController,
                        labelText: 'Select the date',
                        onTap: () {
                          _selectDate(context);
                        },
                        isReadOnly: true,
                        autoFocus: false,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.calendar_month,
                              color: AppColors.disabledBorderColor,
                            ),
                            SizedBox(width: 16)
                          ],
                        ),
                        validator: (input) =>
                            TaskValidator().isValidTaskDueDate(addTaskBloc.taskDueDate.valueOrNull)
                                ? null
                                : 'please select a task due date.',
                        onChanged: (value) {},
                      );
                    }),
                const SizedBox(height: 32),
                StreamBuilder<AddTaskState?>(
                  stream: addTaskBloc.addTaskState,
                  builder: (context, snapshot) {
                    final state = snapshot.data;

                    if (state?.isLoading() ?? false) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state?.isError() ?? false) {
                      return Center(
                        child: Text(state?.error?.toString() ?? 'Something went wrong.'),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (widget.task != null) {
                          addTaskBloc.updateTask(
                            Task(
                                taskName: addTaskBloc.taskName.value,
                                taskDescription: addTaskBloc.taskDescription.value,
                                timestamp: addTaskBloc.taskDueDate.value,
                                isCompleted: widget.task?.isCompleted,
                                id: widget.task?.id),
                          );
                        } else if (_formKey.currentState?.validate() ?? false) {
                          addTaskBloc.addTask();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(125, 30), backgroundColor: AppColors.fABColor),
                      child: Text(
                        widget.task != null ? 'Update' : 'Add',
                        style: AppTextStyle.appBarTitle,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
