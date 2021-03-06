#!/bin/zsh

MY_PATH="`dirname \"$0\"`"

csv=$1
output_dir=${2:-export-meshes-gltf}
input_type=id
input_format=kmz
output_format=gltf
n=8

opts="--input_type ${input_type} --input_format ${input_format} --output_format ${output_format} --assetType model --embed_images --export_textures none --require_faces --use_search_controller --include_group --normalize_size diagonal --center"

date
mkdir -p $output_dir
mkdir -p $output_dir/meshes
mkdir -p $output_dir/logs
parallel --colsep=',' -j $n --eta "node --max-old-space-size=4000 $MY_PATH/../export-mesh.js --output_dir $output_dir/meshes --input {1} $opts >& $output_dir/logs/{1}.export.log" :::: $csv
date