# init jenkins 
service jenkins start

echo waiting for jenkins start
sleep 1m

# get jenkins cli command
echo wget http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar
wget http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar

echo install git plugin
java -jar jenkins-cli.jar -s http://127.0.0.1:8080 install-plugin git

echo install msbuild plugin
java -jar jenkins-cli.jar -s http://127.0.0.1:8080 install-plugin msbuild

echo install github plugin
java -jar jenkins-cli.jar -s http://127.0.0.1:8080 install-plugin github

echo restart jenkins
java -jar jenkins-cli.jar -s http://127.0.0.1:8080 restart

echo waiting for jenkins restart
sleep 1m
