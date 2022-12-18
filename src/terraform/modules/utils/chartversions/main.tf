locals{
   helm_config = yamldecode(var.config_file_content)
   updated_versions = [for k, v in var.input_versions:{
       chart_version = coalesce(v.chart_version, local.helm_config["helm_versions"][k].chart_version)
     }
   ]
   new_versions = zipmap(keys(var.input_versions), local.updated_versions)
}