# Plotting stuff

This repository is my local storage of things i've done with jupyter.
For a great howto, see https://berthub.eu/articles/posts/from-gnuplot-to-matplotlib-pandas/

I start this with:
```
source bin/activate
jupyter notebook --ip=192.168.1.100 --port 9999 --no-browser --notebook-dir=<directory of notebook>
```

How i install this:
```
python3.7 -m virtualenv -p python3.7 plotting
cd plotting/
source bin/activate
python -m pip install jupyter pandas matplotlib numpy lxml folium geopandas geojson
```


## What's in here?

### Pingstats
pingstats is a silly little script + jupyter notebook that creates a ping graph. You can really do this better with other software. Reason i made it was to get 'more' pings. A lot of the network or smokeping graphical systems do an average or every 5 minutes or so. I wanted to create more data points.

### drayteksnr
The draytek vigor 130 modem that i have shows some statistics on it's main page about the DSL line. Primarily the SNR is interesting here. I wanted to graph this and made a script to parse the page and store it as CSV.
The script requires a SESSION KEY parameter which is a cookie that you get when you login. Use your browser debug tools to check out that header.
