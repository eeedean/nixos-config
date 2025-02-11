#!/usr/bin/env python3
'''
Source: https://www.redpill-linpro.com/techblog/2020/02/18/awscli.html
'''

import sys
import configparser
import json
import os
from os.path import expanduser

if(len(sys.argv) <= 1 ):
    exit("Need named profile")


home = expanduser("~")
requestedProfile = sys.argv[1]
awsConfig = configparser.ConfigParser()
awsCred   = configparser.ConfigParser()

awsConfig.read("%s/.aws/config" % home)
awsCred.read('%s/.aws/credentials' % home)

try:
    mfaARN = awsConfig[awsConfig["profile " + requestedProfile]['source_profile']]['mfa_serial']
except KeyError:
    try:
        mfaARN = awsConfig['default']['mfa_serial']
    except KeyError:
        exit("Need MFA serial in config file")

profiles = set( awsCred.sections())
configprofiles = set( awsConfig.sections())

if( requestedProfile in profiles and "profile " + requestedProfile in configprofiles):
    print("Updating %s profile" % requestedProfile)
else:
    if( "profile " + requestedProfile in configprofiles):
        print("Creating %s credentials profile" % requestedProfile)
        awsCred.add_section(requestedProfile)
    else:
        exit("No such profile \"%s\" in config" % requestedProfile )

try:
    OneTimeNumber = int(input("OTP from device: "))
except ValueError:
    exit("OTP must be a number")


response = os.popen("aws --profile %s sts get-session-token --serial-number  %s --token-code %s" % ( awsConfig["profile " + requestedProfile]['source_profile'],
                                                                                                 mfaARN,
                                                                                                 str(OneTimeNumber).zfill(6))).read()

try:
    myjson = json.loads(response)
except json.decoder.JSONDecodeError:
    exit("AWS was not happy with that one")

awsCred[requestedProfile]['aws_access_key_id']     = myjson['Credentials']['AccessKeyId']
awsCred[requestedProfile]['aws_secret_access_key'] = myjson['Credentials']['SecretAccessKey']
awsCred[requestedProfile]['aws_session_token']     = myjson['Credentials']['SessionToken']

with open('%s/.aws/credentials' % home, 'w') as awsCredfile:
    awsCred.write(awsCredfile)