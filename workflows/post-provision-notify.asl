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
        "to": "$$.Requester.email",
        "subject": "ManageIQ - Service Provision Completed",
        "body": "Hello,\n\nYour requested service has been successfully provisioned.\n\nService Status : SUCCESS\nProvisioned By : ManageIQ\nWorkflow : post-provision-notify\n\nThank you for using the ManageIQ Service Catalog."
      },
      "End": true
    }
  }
}
