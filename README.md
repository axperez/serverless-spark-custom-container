# serverless-spark-custom-container
Google Cloud Serverless Spark Custom Container example

1. Edit the build.sh file with your Artifact Registry or Google Container Registry URI
2. Run the build.sh script:
```bash
bash build.sh
```
3. Reference the AR or GCR container path when running serverless spark batch jobs or creating an interactive session via Vertex AI Workbench.