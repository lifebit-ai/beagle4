FROM continuumio/miniconda:4.5.4
MAINTAINER Pablo Prieto <pablo@lifebit.ai>
LABEL authors="pablo@lifebit.ai" \
      description="Docker image containing Beagle4 Conda package"

RUN apt-get update && apt-get install -y procps && apt-get clean -y 
RUN conda install conda=4.6.7

COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
ENV PATH /opt/conda/envs/beagle4/bin:$PATH
