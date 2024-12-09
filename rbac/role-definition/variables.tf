variable "scope_map" {
  description = "A map of scope keys to their corresponding data resources"
  type        = list(object({ key = string, value = string }))
}

variable "architype" {
  description = "A JSON object containing role definitions"
  type        = any
}