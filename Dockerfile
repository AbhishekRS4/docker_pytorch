FROM anibali/pytorch:2.0.1-cuda11.8

# Set up time zone.
ENV TZ=UTC
RUN sudo ln -snf /usr/share/zoneinfo/$TZ /etc/localtime

# install required python packages
RUN pip install wandb --upgrade
RUN pip install scikit-image
RUN pip install scikit-learn
