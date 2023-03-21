# serverless-spark-custom-container
Google Cloud Serverless Spark Custom Container example

1. Edit the build.sh file with your Artifact Registry or Google Container Registry URI
2. Add your own conda and pip packages to the build/environment.yml (the packages in the file currently are just used as an example and should be removed with your own)
3. Run the build.sh script:
```bash
bash build.sh
```
4. Reference the AR or GCR container path when running serverless spark batch jobs or creating an interactive session via Vertex AI Workbench.