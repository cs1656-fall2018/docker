# cs1656 - Docker for CS1656 Development Environment

### Step 1
Install Docker Desktop from 
[www.docker.com](https://www.docker.com).

We would suggest to restart your machine after installation.

### Step 2
Download all files from the repository to a local directory.

### Step 3
Navigate to the local directory on a terminal

### Step 4:
Run

```
docker build -t cs1656 .
```
    
The dot in the end is important.
This will take a long time, possibly an hour.
There is a chance that when you first set everything up, you can encounter unknown problems. Try restarting your machine, as it will probably solve them.
When it finishes, you should see
```
	Successfully tagged ***cs1656:latest***
```
along with a security warning if not under linux.

### Step 5
To enable having a local workspace (on Windows, not needed otherwise) we must enable a disk drive for sharing.
- under Windows:
	Right click on the docker tray icon and click "Settings".
	Click on the "Shared Drives" tab
	Enable the tick box(es) for the drive(s) that contain potential workspace directories

### Step 6
Done!

To run the container go to any directory that you want to be your workspace and run
- under Windows:
```
    docker run -i -t --mount type=bind,source="%cd%",target=/home -p 80:80 -p 7474:7474 -p 7687:7687 -p 8484:8484 -p 8888:8888 -p 3306:3306 -p 1234:1234 cs1656
```
- under Mac/Linux:
```
    docker run -i -t --mount type=bind,source="$PWD",target=/home -p 80:80 -p 7474:7474 -p 7687:7687 -p 8484:8484 -p 8888:8888 -p 3306:3306 -p 1234:1234 cs1656
```

Inside the container, your local directory is mounted under ***/home***.
You can access the web interface on your browser at [http://localhost](http://localhost).

The main page has 5 buttons that will take you to a specific service:
- "jupyter" accesses the workspace directory for jupyter
-  "phpMyAdmin" accesses the local MySql server (MariaDB).
- "Neo4j" accesses the local Neo4j server.
- "adminMongo" accesses the local MongoDB server.
- "sqlite-view" accesses an sqlite database.
  - The button is initially disabled. In order to access a particular sqlite file inside the container, run
    ```
    sqlite-view <filepath>
    ```
	and the button will be enabled, allowing you to access the database on the file ***\<filepath\>***.
    
### Notes
- Some times when you start the docker container, Jupyter will not work immediately. Give it 20 seconds or restart the container to try again until it works.
- Generally, if something doesn't work sometimes, like port binding or any internal service, restarting the container seems to fix the problem.