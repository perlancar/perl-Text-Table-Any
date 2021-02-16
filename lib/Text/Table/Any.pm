package Text::Table::Any;

# AUTHORITY
# DATE
# DIST
# VERSION

#IFUNBUILT
use 5.010001;
use strict;
use warnings;
#END IFUNBUILT

our @BACKENDS = qw(
                      Term::TablePrint
                      Text::ANSITable
                      Text::ASCIITable
                      Text::FormatTable
                      Text::MarkdownTable
                      Text::Table
                      Text::Table::ASV
                      Text::Table::CSV
                      Text::Table::HTML
                      Text::Table::HTML::DataTables
                      Text::Table::LTSV
                      Text::Table::Org
                      Text::Table::Paragraph
                      Text::Table::Span
                      Text::Table::Sprintf
                      Text::Table::Tiny
                      Text::Table::TinyBorderStyle
                      Text::Table::TinyColor
                      Text::Table::TinyColorWide
                      Text::Table::TinyWide
                      Text::Table::TSV
                      Text::Table::XLSX
                      Text::TabularDisplay
              );

sub _encode {
    my $val = shift;
    $val =~ s/([\\"])/\\$1/g;
    "\"$val\"";
}

sub backends {
    @BACKENDS;
}

sub table {
    my %params = @_;

    my $rows       = $params{rows} or die "Must provide rows!";
    my $backend    = $params{backend} || 'Text::Table::Tiny';
    my $header_row = $params{header_row} // 1;

    if ($backend eq 'Text::Table::Tiny') {
        require Text::Table::Tiny;
        return Text::Table::Tiny::table(
            rows => $rows, header_row => $header_row) . "\n";
    } elsif ($backend eq 'Text::Table::TinyBorderStyle') {
        require Text::Table::TinyBorderStyle;
        return Text::Table::TinyBorderStyle::table(
            rows => $rows, header_row => $header_row) . "\n";
    } elsif ($backend eq 'Text::Table::TinyColor') {
        require Text::Table::TinyColor;
        return Text::Table::TinyColor::table(
            rows => $rows, header_row => $header_row) . "\n";
    } elsif ($backend eq 'Text::Table::TinyColorWide') {
        require Text::Table::TinyColorWide;
        return Text::Table::TinyColorWide::table(
            rows => $rows, header_row => $header_row) . "\n";
    } elsif ($backend eq 'Text::Table::TinyWide') {
        require Text::Table::TinyWide;
        return Text::Table::TinyWide::table(
            rows => $rows, header_row => $header_row) . "\n";
    } elsif ($backend eq 'Text::Table::Span') {
        require Text::Table::Span;
        return Text::Table::Span::generate_table(
            rows => $rows, header_row => $header_row) . "\n";
    } elsif ($backend eq 'Text::Table::Sprintf') {
        require Text::Table::Sprintf;
        return Text::Table::Sprintf::table(
            rows => $rows, header_row => $header_row) . "\n";
    } elsif ($backend eq 'Text::Table::Org') {
        require Text::Table::Org;
        return Text::Table::Org::table(
            rows => $rows, header_row => $header_row);
    } elsif ($backend eq 'Text::Table::CSV') {
        require Text::Table::CSV;
        return Text::Table::CSV::table(
            rows => $rows, header_row => $header_row);
    } elsif ($backend eq 'Text::Table::TSV') {
        require Text::Table::TSV;
        return Text::Table::TSV::table(
            rows => $rows);
    } elsif ($backend eq 'Text::Table::LTSV') {
        require Text::Table::LTSV;
        return Text::Table::LTSV::table(
            rows => $rows);
    } elsif ($backend eq 'Text::Table::ASV') {
        require Text::Table::ASV;
        return Text::Table::ASV::table(
            rows => $rows, header_row => $header_row);
    } elsif ($backend eq 'Text::Table::HTML') {
        require Text::Table::HTML;
        return Text::Table::HTML::table(
            rows => $rows, header_row => $header_row);
    } elsif ($backend eq 'Text::Table::HTML::DataTables') {
        require Text::Table::HTML::DataTables;
        return Text::Table::HTML::DataTables::table(
            rows => $rows, header_row => $header_row);
    } elsif ($backend eq 'Text::Table::Paragraph') {
        require Text::Table::Paragraph;
        return Text::Table::Paragraph::table(
            rows => $rows, header_row => $header_row);
    } elsif ($backend eq 'Text::ANSITable') {
        require Text::ANSITable;
        my $t = Text::ANSITable->new(
            use_utf8 => 0,
            use_box_chars => 0,
            use_color => 0,
            border_style => 'ASCII::SingleLine',
        );
        # XXX pick an appropriate border style when header_row=0
        if ($header_row) {
            $t->columns($rows->[0]);
            $t->add_row($rows->[$_]) for 1..@$rows-1;
        } else {
            $t->columns([ map {"col$_"} 0..$#{$rows->[0]} ]);
            $t->add_row($_) for @$rows;
        }
        return $t->draw;
    } elsif ($backend eq 'Text::ASCIITable') {
        require Text::ASCIITable;
        my $t = Text::ASCIITable->new();
        if ($header_row) {
            $t->setCols(@{ $rows->[0] });
            $t->addRow(@{ $rows->[$_] }) for 1..@$rows-1;
        } else {
            $t->setCols(map { "col$_" } 0..$#{ $rows->[0] });
            $t->addRow(@$_) for @$rows;
        }
        return "$t";
    } elsif ($backend eq 'Text::FormatTable') {
        require Text::FormatTable;
        my $t = Text::FormatTable->new(join('|', ('l') x @{ $rows->[0] }));
        $t->head(@{ $rows->[0] });
        $t->row(@{ $rows->[$_] }) for 1..@$rows-1;
        return $t->render;
    } elsif ($backend eq 'Text::MarkdownTable') {
        require Text::MarkdownTable;
        my $out = "";
        my $fields =  $header_row ?
            $rows->[0] : [map {"col$_"} 0..$#{ $rows->[0] }];
        my $t = Text::MarkdownTable->new(file => \$out, columns => $fields);
        foreach (($header_row ? 1:0) .. $#{$rows}) {
            my $row = $rows->[$_];
            $t->add( {
                map { $fields->[$_] => $row->[$_] } 0..@$fields-1
            });
        }
        $t->done;
        return $out;
    } elsif ($backend eq 'Text::Table') {
        require Text::Table;
        my $t = Text::Table->new(@{ $rows->[0] });
        $t->load(@{ $rows }[1..@$rows-1]);
        return $t;
    } elsif ($backend eq 'Text::TabularDisplay') {
        require Text::TabularDisplay;
        my $t = Text::TabularDisplay->new(@{ $rows->[0] });
        $t->add(@{ $rows->[$_] }) for 1..@$rows-1;
        return $t->render . "\n";
    } elsif ($backend eq 'Text::Table::XLSX') {
        require Text::Table::XLSX;
        return Text::Table::XLSX::table(
            rows => $rows, header_row => $header_row);
    } elsif ($backend eq 'Term::TablePrint') {
        require Term::TablePrint;
        my $rows2;
        if ($header_row) {
            $rows2 = $rows;
        } else {
            $rows2 = [@$rows];
            shift @$rows2;
        }
        return Term::TablePrint::print_table($rows);
    } else {
        die "Unknown backend '$backend'";
    }
}

1;
#ABSTRACT: Generate text table using one of several backends

=head1 SYNOPSIS

 use Text::Table::Any;

 my $rows = [
     # header row
     ['Name', 'Rank', 'Serial'],
     # rows
     ['alice', 'pvt', '123456'],
     ['bob',   'cpl', '98765321'],
     ['carol', 'brig gen', '8745'],
 ];
 print Text::Table::Any::table(rows => $rows, header_row => 1,
                               backend => 'Text::Table::Tiny');


=head1 DESCRIPTION

This module provides a single function, C<table>, which formats a
two-dimensional array of data as text table, using one of several available
backends. The interface is modelled after L<Text::Table::Tiny> (0.03);
Text::Table::Tiny also happens to be the default backend.

The example shown in the SYNOPSIS generates the following table:

 +-------+----------+----------+
 | Name  | Rank     | Serial   |
 +-------+----------+----------+
 | alice | pvt      | 123456   |
 | bob   | cpl      | 98765321 |
 | carol | brig gen | 8745     |
 +-------+----------+----------+

When using C<Text::Table::Org> backend, the result is something like:

 | Name  | Rank     | Serial   |
 |-------+----------+----------|
 | alice | pvt      | 123456   |
 | bob   | cpl      | 98765321 |
 | carol | brig gen | 8745     |

When using C<Text::Table::CSV> backend:

 "Name","Rank","Serial"
 "alice","pvt","123456"
 "bob","cpl","98765321"
 "carol","brig gen","8745"

When using C<Text::ANSITable> backend:

 .-------+----------+----------.
 | Name  | Rank     |   Serial |
 +-------+----------+----------+
 | alice | pvt      |   123456 |
 | bob   | cpl      | 98765321 |
 | carol | brig gen |     8745 |
 `-------+----------+----------'

When using C<Text::ASCIITable> backend:

 .-----------------------------.
 | Name  | Rank     | Serial   |
 +-------+----------+----------+
 | alice | pvt      |   123456 |
 | bob   | cpl      | 98765321 |
 | carol | brig gen |     8745 |
 '-------+----------+----------'

When using C<Text::FormatTable> backend:

 Name |Rank    |Serial
 alice|pvt     |123456
 bob  |cpl     |98765321
 carol|brig gen|8745

When using C<Text::MarkdownTable> backend:

 | Name  | Rank     | Serial   |
 |-------|----------|----------|
 | alice | pvt      | 123456   |
 | bob   | cpl      | 98765321 |
 | carol | brig gen | 8745     |

When using C<Text::Table> backend:

 Name  Rank     Serial
 alice pvt        123456
 bob   cpl      98765321
 carol brig gen     8745

When using C<Text::TabularDisplay> backend:

 +-------+----------+----------+
 | Name  | Rank     | Serial   |
 +-------+----------+----------+
 | alice | pvt      | 123456   |
 | bob   | cpl      | 98765321 |
 | carol | brig gen | 8745     |
 +-------+----------+----------+


=head1 FUNCTIONS

=head2 table

Usage:

 table(%params) => str

Known arguments:

=over

=item * rows (aoaos)

Required. Takes an array reference which should contain one or more rows of
data, where each row is an array reference.

=item * backend (str, default C<Text::Table::Tiny>)

Optional. Pick a backend module. Supported backends:

=over

# CODE: require Text::Table::Any; for (@Text::Table::Any::BACKENDS) { print "=item * $_\n\n" }

=back

=item * header_row (bool, default 0)

Optional. If given a true value, the first row in the data will be interpreted
as a header row, and separated visually from the rest of the table (e.g. with a
ruled line). But some backends won't display differently.

=back

=head2 backends

Return list of supported backends. You can also get the list from the
L</@BACKENDS> package variable.


=head1 VARIABLES

=head2 @BACKENDS

List of supported backends.


=head1 SEE ALSO

L<Acme::CPANModules::TextTable>

=cut
