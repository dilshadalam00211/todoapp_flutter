import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo/style/app_colors.dart';
import 'package:flutter_todo/util/date_util.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    Key? key,
    required this.taskName,
    required this.taskDescription,
    required this.taskTimeStamp,
    required this.onChanged,
    required this.onDelete,
    required this.taskCompleted,
    required this.onDeletePressed,
    required this.onTap,
  }) : super(key: key);
  final String taskName, taskDescription;
  final DateTime? taskTimeStamp;
  final void Function(bool?) onChanged;
  final bool taskCompleted;
  final Function(BuildContext) onDeletePressed;
  final VoidCallback onDelete, onTap;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: onDelete,
        ),
        children: [
          SlidableAction(
            onPressed: onDeletePressed,
            backgroundColor: AppColors.deleteColor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: ListTile(
          title: Text(taskName),
          onTap: onTap,
          subtitle: Text(
              '$taskDescription\n${DateUtil.formatDate(taskTimeStamp ?? DateTime.now(), 'dd/MM/yyyy')}'),
          trailing: Checkbox(
            onChanged: onChanged,
            value: taskCompleted,
          ),
        ),
      ),
    );
  }
}
