

###########################
# cloudwatch alarms modules

module cloudwatch_cpu {
  source = "./modules/cloudwatch_alarms"
  alarmname = "cpuUtilizationAlarm"
  metricname = "CPUUtilization"  #using cloudwatch agent
  namespace = "aws/ec2"
.
.
.
}

module cloudwatch_memory {
  source = "./modules/cloudwatch_alarms"
  alarmname = "memoryUtilizationAlarm"
  metricname = "MemoryUtilization"  #or mem-used-percent if not using cloudwatch agent
  namespace = "aws/ec2"
.
.
.
}


module cloudwatch_disk {
  source = "./modules/cloudwatch_alarms"
  alarmname = "diskUtilizationAlarm"
  metricname = "DiskUtilization"  
  namespace = "aws/ec2"

}

module cloudwatch_network {
  source = "./modules/cloudwatch_alarms"
  alarmname = "networkUtilizationAlarm"
  metricname = "NetworkUtilization"  
  namespace = "aws/ec2"

}


module cloudwatch_instance {
  source = "./modules/cloudwatch_alarms"
  alarmname = "instanceStatusAlarm"
  metricname = "InstanceStatus"  
  namespace = "aws/ec2"

}
###################
# log group module

module cloudwatch_log_group {
    souurce = "./modules/cloudwatch_log_group"
    log_group_name = "myapp-logs"
    retention_in_days = 7
}