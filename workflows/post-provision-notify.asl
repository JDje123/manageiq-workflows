{
  "Comment": "Post Provision Workflow",
  "StartAt": "LogStart",
  "States": {
    "LogStart": {
      "Type": "Task",
      "Resource": "manageiq://log",
      "Parameters": {
        "level": "info",
        "message": "Provisioning completed successfully."
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
        "to": "manuttan5223@gmail.com",
        "subject": "ManageIQ - Ubuntu VM Provision Completed",
        "body": "Hello,\n\nYour Ubuntu Linux VM has been successfully provisioned through the ManageIQ Service Catalog.\n\nStatus : Success\nProvisioned By : ManageIQ\nWorkflow : post-provision-notify\n\nThank you."
      },
      "End": true
    }
  }
}
