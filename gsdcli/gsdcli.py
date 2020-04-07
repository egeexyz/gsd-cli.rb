import os
import yaml 
import click
import getpass
from installer import initializeServer

@click.group()
def gsdcli():
    pass

@gsdcli.command()
@click.argument('name')
def install(name):
    serverObj = parseSupported(name)

    if os.path.exists(serverObj.get('path')) == False:
        os.mkdir(serverObj.get('path'))
        os.mkdir(f'{os.path.expanduser("~")}/.config/systemd/user')

@gsdcli.command()
@click.argument('name')
def update(name):
    print(f'Updating {name}')

def parseSupported(name):
    serverYaml = open('./gsdcli/_servers.yaml') # This needs to be fixed
    serverList = yaml.load(serverYaml, Loader=yaml.FullLoader)
    serverObj = serverList.get(name)
    if serverObj :
        configureMetadata(name, serverObj)
        return serverObj
    else:
        exit(f'{name} Not supported')

def configureMetadata(name, serverObj):
    serverObj.update({'friendly-name' : name})
    serverObj.update({'user' : getpass.getuser()})
    serverObj.update({'path' : f'{os.path.expanduser("~")}/{name}-server'})
    serverObj.update({'dryrun' : 'ye'})

def initializeServer(serverObj):
    createDirectories()
    createLaunchScript()
    createUnitFile()

def createDirectories():
    pass

def createLaunchScript():
    pass

def createUnitFile():
    pass

def backupFile():
    pass
