variable "task_definitions" {
  description = "ECS Task Definitions."

  type = map(object({
    family            : string
    network_mode      : string
    memory            : string
    cpu               : string
    execution_role_arn: string
    task_role_arn     : string
    container_definitions: list(object({
      name                : string
      image               : string
      essential           : string
      cpu                 : number
      memory              : number
      essential           : bool
      containerPort       : number
      hostPort            : number
      healthCheck_retries : number
      healthCheck_interval: number
      healthcheck_timeout : number
      healthcheck_startperiod: number
      command             : list(string)
    }))
  }))
  
  default = {}
}
