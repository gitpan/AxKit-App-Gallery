# $Id: Makefile.PL,v 1.2 2003/03/30 22:15:12 nik Exp $

use ExtUtils::MakeMaker;


# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'AxKit::App::Gallery',
#    'VERSION_FROM' => 'lib/AxKit/App/Gallery.pm', # finds $VERSION
    'VERSION'	=> '0.4',
    'PREREQ_PM' => {
		    AxKit => 1.61,
		    Data::Page => 0.15,
		    XML::LibXSLT => 1.53,
                    XML::LibXML => 1.52,
		    XML::Simple => 1.08,
		    Imager => 0.41,
		    URI => 1.23,
		    Image::Info => 1.08,
		   },
);

if (eval { require XML::LibXML }) {
    if (XML::LibXML->VERSION > '1.52') {
        die <<"REASON";

***** ERROR *****

Your XML::LibXML version is greater than 1.52.  At the time of writing,
both versions 1.53 and 1.54 (beta versions) have issues which mean they
do not work with AxKit and AxKit::App::Gallery.

Please downgrade to version 1.52 which is known to be stable.

REASON
    }
}

