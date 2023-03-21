# serverless-spark-custom-container
Google Cloud Serverless Spark Custom Container example

1. Edit the build.sh file with your Artifact Registry or Google Container Registry URI (modify script as needed)
2. Add your own conda and pip packages to the `build/environment.yml` (the packages in the file currently are just used as an example and should be removed with your own)
3. Modify the  `build/Dockerfile` as required
4. Run the build.sh script:
```bash
bash build.sh
```
5. Reference the AR or GCR container path when running serverless spark batch jobs or creating an interactive session via Vertex AI Workbench.

Batch Job:
```bash
gcloud dataproc batches submit pyspark \
    gs://bucket-name/serverless-spark/custom-container/test_import.py \
    --batch example-batch-name \
    --project project-name \
    --region us-central1 \
    --subnet projects/project-name/regions/us-central1/subnetworks/host-shared-vpc \
    --version 2.0 \
    --container-image us-docker.pkg.dev/my-project/serverless-spark/my-image:1.0.1 \
    --history-server-cluster projects/project-name/regions/us-central1/clusters/spark-phs \
    --properties "spark.driver.cores=4,
                  spark.dynamicAllocation.executorAllocationRatio=0.3,
                  spark.executor.cores=4,
                  spark.executor.instances=2" 
```
Interactive Session:
```bash
gcloud beta dataproc sessions create spark example-session-name  \
    --project project-name \
    --location us-central1 \
    --subnet projects/project-name/regions/us-central1/subnetworks/host-shared-vpc \
    --version 2.0 \
    --container-image us-docker.pkg.dev/my-project/serverless-spark/my-image:1.0.1 \
    --history-server-cluster projects/project-name/regions/us-central1/clusters/spark-phs \
    --property "spark.driver.cores=4,
                spark.dynamicAllocation.executorAllocationRatio=0.3,
                spark.executor.cores=4,
                spark.executor.instances=2"

```

Note: Just example commands attempting to show how you could pass in different properties along with your custom container and persistent history server when running serverless spark
