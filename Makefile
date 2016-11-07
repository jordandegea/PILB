


run:
	processing-java --sketch=`pwd`/project --output=`pwd`/project/output --force --run | sed '/\.xml/d'

detect_visage:
	processing-java --sketch=`pwd`/detect_visage --output=`pwd`/detect_visage/output --force --run