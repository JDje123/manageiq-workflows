{
  "Comment": "Post Provision Workflow",
  "StartAt": "LogStart",
  "States": {

    "LogStart": {
      "Type": "Task",
      "Resource": "manageiq://log",
      "Parameters": {
        "level": "info",
        "message": "Provisioning completed."
      },
      "Next": "TagService"
    },

    "TagService": {
      "Type": "Task",
      "Resource": "manageiq://api",
      "Parameters": {
        "method": "POST",
        "path": "/api/services/${service_id}/tags",
        "body": {
          "category": "lifecycle",
          "name": "provisioned"
        }
      },
      "Next": "NotifyUser"
    },

    "NotifyUser": {
      "Type": "Task",
      "Resource": "manageiq://email",
      "Parameters": {
        "to": "$$.Requester.email",
        "subject": "Provision Completed",
        "body": "Your VM has been created successfully."
      },
      "End": true
    }

  }
}
