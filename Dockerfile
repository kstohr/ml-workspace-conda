ARG BASE_CONTAINER=gcr.io/deeplearning-platform-release/tf2-cpu
FROM $BASE_CONTAINER

# Install Additional Packages
RUN pip install --quiet --no-cache-dir \
    'pytest-mock==3.5.*' \
    'pylint==2.7.*' \
    'pytest==6.2.2' \
    'coverage==5.5.*' \
    'google-cloud-bigquery==2.11.*' \
    'google-cloud-storage==1.36.*' \
    'google-cloud-logging==2.2.*' \
    'google-api-python-client==2.0.*' \
    'google-cloud-secret-manager==2.3.*' \
    'pandas-gbq==0.14.*' \
    'boto3==1.17.*'

# Install ML packages
RUN conda install --quiet --yes \
    'beautifulsoup4=4.9.*' \
    'conda-forge::blas=*=openblas' \
    'bokeh=2.2.*' \
    'bottleneck=1.3.*' \
    'cloudpickle=1.6.*' \
    'cython=0.29.*' \
    'dask=2021.2.*' \
    'dill=0.3.*' \
    'graphviz=2.47.*' \
    'h5py=3.1.*' \
    'ipywidgets=7.6.*' \
    'ipympl=0.6.*' \
    'jupyter_contrib_nbextensions=0.5.*' \
    'matplotlib-base=3.3.*' \
    'numba=0.52.*' \
    'numexpr=2.7.*' \
    'pandas=1.2.*' \
    'patsy=0.5.*' \
    'protobuf=3.15.*' \
    'pytables=3.6.*' \
    'python-graphviz=0.16.*' \
    'scikit-image=0.18.*' \
    'scikit-learn=0.24.*' \
    'scipy=1.6.*' \
    'seaborn=0.11.*' \
    'sqlalchemy=1.3.*' \
    'statsmodels=0.12.*' \
    'tslearn==0.5.0.*' \
    'sympy=1.7.*' \
    'vincent=0.4.*' \
    'widgetsnbextension=3.5.*' \
    'xlrd=2.0.*'

RUN conda install -c plotly plotly=4.14.3
RUN apt-get update && apt install openssh-server && apt install nano
WORKDIR /tmp
RUN git clone https://github.com/PAIR-code/facets.git && \
    jupyter nbextension install facets/facets-dist/ --sys-prefix && \
    rm -rf /tmp/facets

WORKDIR /home/jupyter
COPY . .

EXPOSE 8080
CMD ["jupyter", "lab", "--port=8080", "--ip=*", "--allow-root"]


