#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// default parameters

params.inputDir = ''
params.outDir = 'out'

process Step0 {
    // merge the input files and filter
    container "centos:7"
    publishDir "${params.outDir}", mode: 'symlink'

    input:
    path input_folder

    output:
    path "md5sums.txt"

    script:
    """
    set -euxo pipefail

    echo "md5sum files in the folder"
    md5sum $input_folder/* >> md5sums.txt

    cat md5sums.txt
    """
}


workflow {

    Step0(Channel.fromPath(params.inputDir))

}

