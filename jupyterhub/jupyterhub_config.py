import tmpauthenticator

c.JupyterHub.authenticator_class = tmpauthenticator.TmpAuthenticator
c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'
c.JupyterHub.hub_ip = '0.0.0.0'
c.JupyterHub.hub_connect_ip = 'jupyterhub'
c.DockerSpawner.network_name = 'jupyterhub_jupyterhub'
