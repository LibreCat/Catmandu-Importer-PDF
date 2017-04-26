use strict;
use warnings;
use utf8;
use Test::More;
use Test::Exception;

my $pkg;
BEGIN {
    $pkg = 'Catmandu::Importer::PDF';
    use_ok $pkg;
}

require_ok $pkg;

my $importer;

lives_ok(sub {

    $importer = Catmandu::Importer::PDF->new( file => 't/pdf/greek.pdf' );

},"importer created");

my $array;

lives_ok(sub{

    $array = $importer->to_array();
    chomp( $array->[0]->{pages}->[0]->{text} );
    $array->[0]->{pages}->[0]->{text} =~ s/\f$//o;

},"imported pdf");

is_deeply($array,[
    {
        document            => {
            author          =>  'njfranck ',
            creation_date   =>  1467800799,
            metadata        => undef,
            creator         =>  "Writer",
            keywords        =>  undef,
            modification_date =>  -1,
            producer        =>  "LibreOffice 4.3",
            subject         =>  undef,
            title           =>  undef,
            version         =>  "PDF-1.4",
        },
        pages               => [
            {
                height  =>  792,
                label   =>  '1',
                text    =>  "ἄνδρα μοι ἔννεπε , μοῦσα , πολύτροπον , ὃς μάλα πολλὰ",
                width   =>  612
            }
        ]
    }
],"pdf read successfully");

done_testing 5;
