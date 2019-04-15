# Creating Info Nodes

Info nodes store global information about a procedural feature.

1. Create a scene extending **info/base/Info.tscn** and save it in *info/FEATURE_NAME*.
2. Attach a script (that just extends `Node`), and define your properties, calculation functions and/or anything else.
3. Add an instance of your new info scene to *info/InfoManager.tscn*.
