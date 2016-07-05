package Catmandu::Importer::PDF;

use Catmandu::Sane;
use Poppler;
use Moo;

our $VERSION = '0.01';

with 'Catmandu::Importer';

sub _createDocFromFilename {
    my $filename = $_[0];

    my $pdf = Poppler::Document->new_from_file( $filename );

    my $num_pages = $pdf->get_n_pages();

    my $record = {
        document => {
            version => $pdf->get_pdf_version_string(),
            title => $pdf->get_title(),
            author => $pdf->get_author(),
            subject => $pdf->get_subject(),
            keywords => $pdf->get_keywords(),
            creator => $pdf->get_creator(),
            producer => $pdf->get_producer(),
            creation_date => $pdf->get_creation_date(),
            modification_date => $pdf->get_modification_date(),
            metadata => $pdf->get_metadata()
        },
        pages => []
    };

    for(my $i = 0;$i < $num_pages;$i++){
        my $page = $pdf->get_page($i);
        my $text = $page->get_text();
        my($w,$h) = $page->get_size;
        my $label = $page->get_label();

        my $p = {
            width => $w,
            height => $h,
            label => $label,
            text => $text
        };

        push @{ $record->{pages} },$p;
    }

    $record;
}

sub generator {
	my ($self) = @_;

	return sub {
        state $doc = undef;

        unless($doc){
            $doc = _createDocFromFilename( $self->file );
            return $doc;
        }
        return;

	}
}
sub DESTROY {
    my ($self) = @_;
    close($self->fh);
}

1;
