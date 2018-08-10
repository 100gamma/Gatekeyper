#! /usr/bin/python3

import ellipses as el

from matplotlib.patches import Ellipse
import IPython.display
from PIL import Image
from optparse import OptionParser
import re


parser = OptionParser()

parser.add_option("-f", "--file", dest="input_filepath",
                  help="Location of image to be corrected", metavar="INPUT_FILEPATH")

parser.add_option("-p", "--points", dest="points",
                  help="Locations of points defined on ellipse. Specified as '(x,y), ...'", metavar="points")

parser.add_option("-o", "--output", dest="output_filepath",
                  help="Location of new image after correction", metavar="output_filepath")

parser.add_option("-d", "--display", action="store_true", dest="display")




(options, args) = parser.parse_args()



if options.input_filepath:
	try:
		Image.open(options.input_filepath)
	except:
		print("Error opening image")
		exit()




extract_pairs = lambda text : [pair.group(0) for pair in re.finditer(r"\(-?[0-9]*\.?[0-9]*\,-?[0-9]*\.?[0-9]*\)", "".join(text.split()))]
num_pairs = lambda extracted : [[float(n) for n in re.sub('[()]','', p).split(',')] for p in extracted]
string_to_list = lambda s : num_pairs(extract_pairs(s))



if options.points:
	point = string_to_list(options.points)
else:
	print("Points must be specified with -p")
	exit()


# unzip the points
x = [d[0] for d in point]
y = [d[1] for d in point]
data_unzipped = [x, y]

# fit ellipse
import numpy as np
lsqe = el.LSqEllipse()
try:
	lsqe.fit(data_unzipped)
except:
	print("Error fitting ellipse\n You probably need to define more/better points")
	exit()
print("Ellipse fitted")

# get output
center, width, height, phi = lsqe.parameters()
angle = np.rad2deg(phi);
major_axis = max(width,height)*2;
minor_axis = min(width,height)*2;
major_factor = major_axis/minor_axis
minor_factor = minor_axis/major_axis

# display output
print("angle: {0:.5f} degrees".format(angle))
print("minor axis: {0:.5f} ({0:.5f}% of major)".format(minor_axis, minor_factor*100))
print("major axis: {0:.5f} ({0:.5f}% of minor)".format(major_axis, major_factor*100))

# display results before transform
def plot_curve(image_path):
	# set up plot
	import matplotlib.pyplot as plt
	fig = plt.figure(figsize=(6,6))
	ax = fig.add_subplot(111)
	ax.axis('equal')
	# make pyplot ellipse
	ellipse = Ellipse(xy=center,
					  width=2*width,
					  height=2*height,
					  angle=np.rad2deg(phi),
					  edgecolor='red',
					  fc='None',
					  lw=2,
					  zorder=1)
	ax.add_patch(ellipse)
	# display points
	ax.plot(x, y, 'bo', zorder=1)
	# display image
	plt.imshow(Image.open(image_path))
	# display
	plt.show()

if options.display:
	plot_curve(options.input_filepath)


if options.output_filepath:
	i = Image.open(options.input_filepath)
	width_factor = 1
	height_factor = major_axis/minor_axis;

	resample = Image.BICUBIC
	resample_rotate = resample
	resample_unrotate = resample
	def unfuck_ellipse(i, angle=0, width_factor=1, height_factor=1, resample=Image.BICUBIC):
	    i = i.rotate(angle, expand=True, resample=resample)
	    i = i.resize((int(i.width*width_factor), int(i.height*height_factor)))
	    i = i.rotate(-angle, expand=True, resample=resample)
	    return i

	corrected = unfuck_ellipse(i, angle, 1, minor_factor)
	print("Correction applied")

	try:
		corrected.save(options.output_filepath)
	except:
		print("Error saving corrected image")
		exit();
	print("New image saved to {}".format(options.output_filepath))
