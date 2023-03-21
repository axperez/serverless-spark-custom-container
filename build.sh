# Change with your project ID and imagine name/tag
IMAGE=gcr.io/my-project/my-image:1.0.1
gsutil cp gs://spark-lib/bigquery/spark-bigquery-with-dependencies_2.13-0.28.1.jar build/.
wget -P build/ https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh
# Build and push docker container image
docker build -t "${IMAGE}" build/.
docker push "${IMAGE}"