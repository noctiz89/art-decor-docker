# art-decor-docker
Dockerfile and assets to create an image of ART-DECOR (www.art-decor.org). The shell scripts are written in/for Bash. However, they should be easy to port to a Windows batch file.

`build.sh`:
* downloads the ART-DECOR Orbeon source, [eXistdb](http://www.exist-db.org) and eXistdb packages from the Nictiz repository
* runs the `docker build` command

`run.sh`
* runs the image/container with `docker run` attaching ports `8877` and `8080`

After calling `run.sh` it should be possible to:
* Logon to the eXist dashboard at [http://localhost:8877](http://localhost:8877/apps/dashboard/index.html) (use `admin/password` or whatever you put in `assets/install_existdb.py`)
* Open ART-DECOR at [http://localhost:8080/art-decor](http://localhost:8080/art-decor/home)


