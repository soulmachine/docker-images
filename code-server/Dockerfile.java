FROM soulmachine/code-server:base

ARG JAVA_VERSION="17.0.1.12.1-amzn"

SHELL ["/bin/bash", "-c"] 

RUN sudo apt -qy update && sudo apt -qy --no-install-recommends install \
    ca-certificates \
    git \
    wget \
 && curl -s "https://get.sdkman.io" | bash \
 && source "/home/$USER/.sdkman/bin/sdkman-init.sh" \
 && sdk install java $JAVA_VERSION \
 && sdk install scala \
 && sdk install kotlin \
 && sdk install maven \
 && sdk install gradle \
 && sdk install sbt \
 && sdk install springboot \
 && rm -rf /home/$USER/.sdkman/archives/* \
 && rm -rf /home/$USER/.sdkman/tmp/* \
 && sudo apt -qy autoremove && sudo apt clean && sudo rm -rf /var/lib/apt/lists/* && sudo rm -rf /tmp/*

COPY --chown=$USER:$USER ./.vscode/settings-java.json /data/.local/share/code-server/User/settings.json

# java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home'
ENV JAVA_HOME="/home/$USER/.sdkman/candidates/java/current"
ENV PATH="$JAVA_HOME/bin:/home/$USER/.sdkman/candidates/scala/current/bin:/home/$USER/.sdkman/candidates/kotlin/current/bin:/home/$USER/.sdkman/candidates/maven/current/bin:/home/$USER/.sdkman/candidates/sbt/current/bin:/home/$USER/.sdkman/candidates/gradle/current/bin:/home/$USER/.sdkman/candidates/springboot/current/bin:$PATH"

RUN code-server --install-extension vscjava.vscode-java-pack \
 && curl --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36" -LJO https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualStudioExptTeam/vsextensions/vscodeintellicode/1.2.14/vspackage \
 && mv VisualStudioExptTeam.vscodeintellicode-1.2.14.vsix VisualStudioExptTeam.vscodeintellicode-1.2.14.vsix.gz \
 && gzip -d VisualStudioExptTeam.vscodeintellicode-1.2.14.vsix.gz \
 && code-server --install-extension VisualStudioExptTeam.vscodeintellicode-1.2.14.vsix \
 && rm VisualStudioExptTeam.vscodeintellicode-1.2.14.vsix \
 && code-server --install-extension Pivotal.vscode-boot-dev-pack \
 && code-server --install-extension scalameta.metals \
 && code-server --install-extension fwcd.kotlin \
 && code-server --install-extension GabrielBB.vscode-lombok
