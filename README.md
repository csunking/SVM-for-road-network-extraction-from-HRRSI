# SVM-for-road-network-extraction-from-HRRSI
SVM for road network extraction from high resolation RS image

This is the version 1.0 
Originaled by weng, 2015-2-5 1331, Nanjing, China.
E-mail: arxive@126.com
The simple purpose is using SVM menthold and realted object based classfication to extract road network form high resolution remote sensing image. My outline are as follows.

1. Get the seeds of classify centers from high resolution image like road
2. get the tiny areas of image like object based homogeneous areas 
3. Construct object classfication feather Vectior for every object, most importantly is that the vector is favourable for road classfication, and should just give the best chance for the post classficaiton processing.
4. Using SVM classficaitonn methood to get the connetct areas of road like object.
5. Post Processing. Vertify, Simplizing, Organization, Extention, Growing, Checking adn Networking, Vetorlizing.
6. Merge show to check the results. And menthods comparing.

Thats all, thanks for your joint in.
