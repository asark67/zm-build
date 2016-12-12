#!/bin/bash
#
# ***** BEGIN LICENSE BLOCK *****
# Zimbra Collaboration Suite Server
# Copyright (C) 2009, 2010, 2011, 2013, 2014, 2015, 2016 Synacor, Inc.
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software Foundation,
# version 2 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program.
# If not, see <https://www.gnu.org/licenses/>.
# ***** END LICENSE BLOCK *****

# Shell script to create zimbra store package


#-------------------- Configuration ---------------------------

    currentScript=`basename $0 | cut -d "." -f 1`                          # zimbra-store
    currentPackage=`echo ${currentScript}build | cut -d "-" -f 2` # storebuild

    jettyVersion=jetty-distribution-9.3.5.v20151012


#-------------------- Build Package ---------------------------

    echo -e "\tCreate package directories" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/etc/sudoers.d
    mkdir -p ${repoDir}/zm-build/${currentPackage}/DEBIAN
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf/templates

    echo -e "\tCopy package files" >> ${buildLogFile}

    echo -e "\tCopy etc files" >> ${buildLogFile}
    cp ${repoDir}/zm-build/rpmconf/Env/sudoers.d/02_${currentScript} ${repoDir}/zm-build/${currentPackage}/etc/sudoers.d/02_${currentScript}
    cat ${repoDir}/zm-build/rpmconf/Spec/Scripts/${currentScript}.post >> ${repoDir}/zm-build/${currentPackage}/DEBIAN/postinst
    chmod 555 ${repoDir}/zm-build/${currentPackage}/DEBIAN/*

    echo -e "\tCopy bin files of /opt/zimbra/" >> ${buildLogFile}
    cp -f ${repoDir}/zm-hsm/src/bin/zmhsm ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin/zmhsm
    cp -f ${repoDir}/zm-archive-utils/src/bin/zmarchiveconfig ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin/zmarchiveconfig
    cp -f ${repoDir}/zm-archive-utils/src/bin/zmarchivesearch ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin/zmarchivesearch
    cp -f ${repoDir}/zm-sync-tools/src/bin/zmsyncreverseproxy ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin/zmsyncreverseproxy
    cp -f ${repoDir}/zm-sync-store/src/bin/zmdevicesstats ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin/zmdevicesstats
    cp -f ${repoDir}/zm-sync-store/src/bin/zmgdcutil ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin/zmgdcutil

    echo -e "\tCopy conf files of /opt/zimbra/" >> ${buildLogFile}
    cp -f ${repoDir}/zm-store-conf/conf/globs2 ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf
    cp -f ${repoDir}/zm-store-conf/conf/magic ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf
    cp -f ${repoDir}/zm-store-conf/conf/magic.zimbra ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf
    cp -f ${repoDir}/zm-store-conf/conf/globs2.zimbra ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf
    cp -f ${repoDir}/zm-store-conf/conf/spnego_java_options.in ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf
    cp -f ${repoDir}/zm-store-conf/conf/contacts/zimbra-contact-fields.xml ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf/zimbra-contact-fields.xml
    cp -f ${repoDir}/zm-windows-comp/ZimbraMigrationTools/zmztozmig.conf ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf/zmztozmig.conf
    cp -f ${repoDir}/zm-ews-store/resources/jaxb-bindings.xml ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf
    cp -rf ${repoDir}/zm-web-client/WebRoot/templates/* ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf/templates

    echo -e "\tCopy extensions-extra files of /op/zimbra/" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/extensions-extra/openidconsumer
    cp -f ${repoDir}/zm-openid-consumer-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/extensions-extra/openidconsumer


    echo -e "\tCopy extensions-network-extra files of /op/zimbra/" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/extensions-network-extra
    cp -rf ${repoDir}/zm-saml-consumer-store/build/dist/saml ${repoDir}/zm-build/${currentPackage}/opt/zimbra/extensions-network-extra/

    echo -e "\tCopy ${jettyVersion} files of /op/zimbra/" >> ${buildLogFile}


    echo -e "\tCopy lib files of /opt/zimbra/" >> ${buildLogFile}

    echo -e "\t\tCopy ext files of /opt/zimbra/lib/" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/backup
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-archive
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/voice
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/cisco
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/mitel
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/network
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/com_zimbra_oo
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/convertd
    cp -rf ${repoDir}/zm-backup-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/backup
    cp -rf ${repoDir}/zm-archive-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-archive
    cp -rf ${repoDir}/zm-voice-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-voice-store
    cp -rf ${repoDir}/zm-voice-cisco-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-voice-cisco-store
    cp -rf ${repoDir}/zm-voice-mitel-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-voice-mitel-store
    cp -rf ${repoDir}/zm-ews-stub/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraews
    cp -rf ${repoDir}/zm-ews-common/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraews
    cp -rf ${repoDir}/zm-ews-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraews
    cp -rf ${repoDir}/zm-sync-common/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrasync
    cp -rf ${repoDir}/zm-sync-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrasync
    cp -rf ${repoDir}/zm-sync-tools/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrasync
    cp -rf ${repoDir}/zm-openoffice-store/build/dist/*.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/com_zimbra_oo
    mv ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/com_zimbra_oo/zm-openoffice-store.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/com_zimbra_oo/com_zimbra_oo.jar
    cp -rf ${repoDir}/zm-network-store/build/dist/*.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/network
    cp -rf ${repoDir}/zm-convertd-store/build/dist/*jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/convertd

    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/service
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin
    cp -rf ${repoDir}/zm-backup-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/backup
    cp -rf ${repoDir}/zm-archive-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-archive
    cp -rf ${repoDir}/zm-voice-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-voice-store
    cp -rf ${repoDir}/zm-voice-cisco-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-voice-cisco-store
    cp -rf ${repoDir}/zm-voice-mitel-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-voice-mitel-store
    cp -rf ${repoDir}/zm-ews-stub/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraews
    cp -rf ${repoDir}/zm-ews-common/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraews
    cp -rf ${repoDir}/zm-ews-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraews
    cp -rf ${repoDir}/zm-sync-common/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrasync
    cp -rf ${repoDir}/zm-sync-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrasync
    cp -rf ${repoDir}/zm-sync-tools/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrasync
    cd /opt/zimbra/${jettyVersion}/webapps/service; jar -xf ${repoDir}/zm-store/build/dist/service.war
    cp ${repoDir}/zm-zimlets/build/dist/zimlet.tld WEB_INF

    cd /opt/zimbra/${jettyVersion}/webapps/zimbra; jar -xf ${repoDir}/zm-store/build/dist/zimbra.war
    cp ${repoDir}/zm-touch-client/build/dist/ztouch.css css
    cp ${repoDir}/zm-touch-client/build/dist/loginTouch.jsp public
    cp -rf ${repoDir}/zm-touch-client/build/dist/t .

    #help
    cp  -rf ${repoDir}/zm-help/build/dist/help  .

    #portals
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/portals
    cp  -rf ${repoDir}/zm-webclient-portal-example/build/dist/example portals

    #downloads
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/downloads
    cp  -rf ${repoDir}/zm-downloads/build/dist/. downloads

    #Messages from admin console
    cp  -rf ${repoDir}/zm-admin-console/build/dist/messages/. WEB-INFclasses/messages/

    #robots.txt
    cp  -rf ${repoDir}/zm-aspell/build/dist/conf/robots.txt  .

    echo -e "\t\tStaging on zimbra-Admin" >> ${buildLogFile}
    cd /opt/zimbra/${jettyVersion}/webapps/zimbraAdmin; jar -xf ${repoDir}/zm-store/build/dist/zimbraAdmin.war

    #help
    cp  -rf ${repoDir}/zm-help/build/dist/help .

    #img
    cp  -rf ${repoDir}/zm-web-client/build/dist/img/dwt  img/
    cp  -rf ${repoDir}/zm-web-client/build/dist/img/animated  img/

    echo -e "\t\tCopy ext-common files of /opt/zimbra/lib/" >> ${buildLogFile}

    echo -e "\t\tCopy jars files of /opt/zimbra/lib/" >> ${buildLogFile}


    echo -e "\tCopy libexec files of /opt/zimbra/" >> ${buildLogFile}


    echo -e "\tCopy log files of /opt/zimbra/" >> ${buildLogFile}


    echo -e "\tCopy zimlets files of /opt/zimbra/" >> ${buildLogFile}


    echo -e "\tCopy zimlets-network files of /opt/zimbra/" >> ${buildLogFile}


    echo -e "\tCreate debian package" >> ${buildLogFile}
    (cd ${repoDir}/zm-build/${currentPackage}; find . -type f ! -regex '.*jetty-distribution-.*/webapps/zimbra/WEB-INF/jetty-env.xml' ! \
        -regex '.*jetty-distribution-.*/webapps/zimbraAdmin/WEB-INF/jetty-env.xml' ! -regex '.*jetty-distribution-.*/modules/setuid.mod' ! \
        -regex '.*jetty-distribution-.*/etc/krb5.ini' ! -regex '.*jetty-distribution-.*/etc/spnego.properties' ! -regex '.*jetty-distribution-.*/etc/jetty.xml' ! \
        -regex '.*jetty-distribution-.*/etc/spnego.conf' ! -regex '.*jetty-distribution-.*/webapps/zimbraAdmin/WEB-INF/web.xml' ! \
        -regex '.*jetty-distribution-.*/webapps/zimbra/WEB-INF/web.xml' ! -regex '.*jetty-distribution-.*/webapps/service/WEB-INF/web.xml' ! \
        -regex '.*jetty-distribution-.*/work/.*' ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -print0 | xargs -0 md5sum | \sed -e 's| \./| |' \
        > ${repoDir}/zm-build/${currentPackage}/DEBIAN/md5sums)
    cat ${repoDir}/zm-build/rpmconf/Spec/${currentScript}.deb | sed -e "s/@@VERSION@@/${release}.${buildNo}.${os/_/.}/" -e "s/@@branch@@/${buildTimeStamp}/" \
        -e "s/@@ARCH@@/${arch}/" -e "s/@@ARCH@@/amd64/" -e "s/^Copyright:/Copyright:/" -e "/^%post$/ r ${currentScript}.post"
        > ${repoDir}/zm-build/${currentPackage}/DEBIAN/control
    (cd ${repoDir}/zm-build/${currentPackage}; dpkg -b ${repoDir}/zm-build/${currentPackage} ${repoDir}/zm-build/${arch})

    if [ $? -ne 0 ]; then
        echo -e "\t### ${currentPackage} package building failed ###" >> ${buildLogFile}
    else
        echo -e "\t*** ${currentPackage} package successfully created ***" >> ${buildLogFile}
    fi