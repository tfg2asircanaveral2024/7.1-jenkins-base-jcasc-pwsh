FROM jenkins/jenkins:latest-jdk17

USER root

RUN apt update && apt install wget -y

# instalar Powershell Core con un script
WORKDIR /root
COPY ./script-instalacion-pwsh.sh .
RUN chmod u+x script-instalacion-pwsh.sh && \
	sh -c ./script-instalacion-pwsh.sh && \
	rm script-instalacion-pwsh.sh

COPY script-instalacion-modulos.ps1 .
RUN pwsh script-instalacion-modulos.ps1

WORKDIR /var/jenkins_home
USER jenkins

# evitar que el Wizard para la instalación asistida de Jenkins se lance al iniciar el
# contenedor, porque la configuración la aplicamos con JCasC
ENV JAVA_OPTS='-Djenkins.install.runSetupWizard=false'

# indicar la ubicacion del archivo de configuracion para Jenkins
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/jenkins-casc.yaml

# archivo con el listado de plugins a instalar automáticamente
COPY plugins.txt /var/home_jenkins/plugins.txt
RUN jenkins-plugin-cli --plugin-file /var/home_jenkins/plugins.txt

COPY jenkins-casc.yaml /var/jenkins_home/jenkins-casc.yaml