# Debian 11 is recommended.
FROM debian:11-slim

# Suppress interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# (Required) Install utilities required by Spark scripts.
RUN apt update && apt install -y procps tini

# (Optional) Add extra jars.
ENV SPARK_EXTRA_JARS_DIR=/opt/spark/jars/
ENV SPARK_EXTRA_CLASSPATH='/opt/spark/jars/*'
RUN mkdir -p "${SPARK_EXTRA_JARS_DIR}"
COPY spark-bigquery-with-dependencies_2.13-0.28.1.jar "${SPARK_EXTRA_JARS_DIR}"
RUN chmod 777 "${SPARK_EXTRA_JARS_DIR}/spark-bigquery-with-dependencies_2.13-0.28.1.jar"

# (Optional) Install and configure Miniconda3.
# /opt/dataproc/conda is the path where Dataproc installs Conda. We could install another Conda in another directory (with another ${CONDA_HOME}). But remember to also install ipython there.
ENV CONDA_HOME=/opt/conda
ENV PYSPARK_PYTHON=${CONDA_HOME}/bin/python
ENV PYSPARK_DRIVER_PYTHON=${CONDA_HOME}/bin/ipython
ENV PATH=${CONDA_HOME}/bin:${PATH}
COPY Miniconda3-py39_4.10.3-Linux-x86_64.sh .
RUN bash Miniconda3-py39_4.10.3-Linux-x86_64.sh -b -p ${CONDA_HOME} \
  && ${CONDA_HOME}/bin/conda config --system --set always_yes True \
  && ${CONDA_HOME}/bin/conda config --system --set auto_update_conda False \
  && ${CONDA_HOME}/bin/conda config --system --prepend channels conda-forge \
  && ${CONDA_HOME}/bin/conda config --system --set channel_priority strict
# Also install ipython
RUN ${CONDA_HOME}/bin/conda install ipython ipykernel

# (Optional) Install Conda packages.
#
# The following packages are installed in the default image, it is strongly
# recommended to include all of them.
#
# Use mamba to install packages, because it is much faster.
COPY environment.yml .
RUN ${CONDA_HOME}/bin/conda install mamba -n base -c conda-forge \
    && ${CONDA_HOME}/bin/mamba env update -f environment.yml

# (Required) Create group/user spark.
# The GID and UID must be 1099. Home directory is required.
RUN groupadd -g 1099 spark
RUN useradd -u 1099 -g 1099 -d /home/spark -m spark
USER spark
