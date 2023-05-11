process MEA_PREPROCESS {
    label 'process_single'

    // conda "conda-forge::python=3.8.3"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'docker://jungwooseok/mea_preprocess:latest' }"

    input:
    val mea_params

    output:
    path '*.csv'      , emit: csv

    when:
    task.ext.when == null || task.ext.when

    script: // This script is bundled with the pipeline, in nf-core/multiomicintegration/bin/
    """
    script:
    python3 preprocess.py \\
      --cma_dir "${mea_params.cma_dir}" \\
      --gwas_dir "${mea_params.gwas_dir}" \\
      --twas_dir "${mea_params.twas_dir}" \\
      --staar_dir "${mea_params.staar_dir}" \\
      --output_dir "${mea_params.output_dir}" \\
      --modules_dir "${mea_params.modules_dir}" \\
      --traits "${mea_params.traits_path}" \\
      --categories "${mea_params.categories_path}"
    """
}
