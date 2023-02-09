#!/bin/bash

# START UP THE SERVER; TO AVOID THE CANNOT CREATE SHID ERROR
# Remember that the Dockerfile should have execute for the user
# GRANT +X HERE! (Heathen)
exec /srv/samp03/samp03svr
