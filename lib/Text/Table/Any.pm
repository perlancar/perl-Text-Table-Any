package Text::Table::Any;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our %BACKEND_FEATURES = (
    "Term::Table" => {
        rows => 1,
        header_row => 1,
        separate_rows => 0,
        title => 0,
    },
    "Term::TablePrint" => {
        rows => 1,
        header_row => 1,
        separate_rows => 0,
        title => 0,
    },
    "Text::ANSITable" => {
        rows => 1,
        header_row => 1,
        separate_rows => 1,
        title => 0,
    },
    "Text::ASCIITable" => {
        rows => 1,
        header_row => 1,
        separate_rows => 0,
        title => 0,
    },
    "Text::FormatTable" => {
        rows => 1,
        header_row => 0,
        separate_rows => 0,
        title => 0,
    },
    "Text::MarkdownTable" => {
        rows => 1,
        header_row => 1,
        separate_rows => 0,
        title => 0,
    },
    "Text::Table" => {
        rows => 1,
        header_row => 0,
        separate_rows => 0,
        title => 0,
    },
    "Text::Table::ASV" => {
        rows => 1,
        header_row => 1,
        separate_rows => 0,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::CSV" => {
        rows => 1,
        header_row => 1,
        separate_rows => 0,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::HTML" => {
        rows => 1,
        header_row => 1,
        separate_rows => 0,
        title => 1,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::HTML::DataTables" => {
        rows => 1,
        header_row => 1,
        separate_rows => 0,
        title => 1,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::LTSV" => {
        rows => 1,
        header_row => 0,
        separate_rows => 0,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::Manifold" => {
        rows => 1,
        header_row => 1,
        separate_rows => 0,
        title => 0,
    },
    "Text::Table::More" => {
        rows => 1,
        header_row => 1,
        separate_rows => 1,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::Org" => {
        rows => 1,
        header_row => 1,
        separate_rows => 1,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::Paragraph" => {
        rows => 1,
        header_row => 1,
        separate_rows => 0,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::Sprintf" => {
        rows => 1,
        header_row => 1,
        separate_rows => 1,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::TickitWidget" => {
        rows => 1,
        header_row => 1,
        separate_rows => 0,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::Tiny" => {
        rows => 1,
        header_row => 1,
        separate_rows => 1,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::TinyBorderStyle" => {
        rows => 1,
        header_row => 1,
        separate_rows => 1,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::TinyColor" => {
        rows => 1,
        header_row => 1,
        separate_rows => 1,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::TinyColorWide" => {
        rows => 1,
        header_row => 1,
        separate_rows => 1,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::TinyWide" => {
        rows => 1,
        header_row => 1,
        separate_rows => 1,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::TSV" => {
        rows => 1,
        header_row => 0,
        separate_rows => 0,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::Table::XLSX" => {
        rows => 1,
        header_row => 1,
        separate_rows => 0,
        title => 0,
        backend_opts => 1,
        backend_opts_note => "Backend-specific options (backend_opts) will be passed to table() or generate_table() directly",
    },
    "Text::TabularDisplay" => {
        rows => 1,
        header_row => 0,
        separate_rows => 0,
        title => 0,
    },
    "Text::UnicodeBox::Table" => {
        rows => 1,
        header_row => 1,
        separate_rows => 0,
        title => 0,
    },
);

our @BACKENDS = sort keys %BACKEND_FEATURES;

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

    my $rows          = $params{rows} or die "Must provide rows!";
    my $backend       = $params{backend} || 'Text::Table::Sprintf';
    my $header_row    = $params{header_row} // 1;
    my $separate_rows = $params{separate_rows} // 0;

    if ($backend eq 'Term::Table') {
        require Term::Table;
        my ($header, $data_rows);
        if ($header_row) {
            $header = $rows->[0];
            $data_rows = [ @{$rows}[1 .. $#{$rows}] ];
        } else {
            $header = [ map {"col$_"} 0..$#{$rows->[0]} ];
            $data_rows = $rows;
        }
        my $table = Term::Table->new(
            header => $header,
            rows   => $data_rows,
        );
        return join("\n", $table->render)."\n";
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
        $t->show_row_separator(1) if $separate_rows;
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
    } elsif ($backend eq 'Text::Table::ASV') {
        require Text::Table::ASV;
        return Text::Table::ASV::table(
            rows => $rows,
            header_row => $header_row,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        );
    } elsif ($backend eq 'Text::Table::CSV') {
        require Text::Table::CSV;
        return Text::Table::CSV::table(
            rows => $rows,
            header_row => $header_row,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        );
    } elsif ($backend eq 'Text::Table::HTML') {
        require Text::Table::HTML;
        return Text::Table::HTML::table(
            rows => $rows,
            header_row => $header_row,
            (title => $params{title}) x !!defined($params{title}),
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        );
    } elsif ($backend eq 'Text::Table::HTML::DataTables') {
        require Text::Table::HTML::DataTables;
        return Text::Table::HTML::DataTables::table(
            rows => $rows,
            header_row => $header_row,
            (title => $params{title}) x !!defined($params{title}),
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        );
    } elsif ($backend eq 'Text::Table::LTSV') {
        require Text::Table::LTSV;
        return Text::Table::LTSV::table(
            rows => $rows,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        );
    } elsif ($backend eq 'Text::Table::Manifold') {
        require Text::Table::Manifold;
        my $t = Text::Table::Manifold->new;
        if ($header_row) {
            $t->headers($rows->[0]);
            $t->data([ @{$rows}[1 .. $#{$rows}] ]);
        } else {
            $t->headers([ map {"col$_"} 0..$#{$rows->[0]} ]);
            $t->data($rows);
        }
        return join("\n", @{$t->render(padding => 1)}) . "\n";
    } elsif ($backend eq 'Text::Table::More') {
        require Text::Table::More;
        return Text::Table::More::generate_table(
            rows => $rows,
            header_row => $header_row,
            separate_rows => $separate_rows,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        ) . "\n";
    } elsif ($backend eq 'Text::Table::Org') {
        require Text::Table::Org;
        return Text::Table::Org::table(
            rows => $rows,
            header_row => $header_row,
            separate_rows => $separate_rows,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        );
    } elsif ($backend eq 'Text::Table::Paragraph') {
        require Text::Table::Paragraph;
        return Text::Table::Paragraph::table(
            rows => $rows,
            header_row => $header_row,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        );
    } elsif ($backend eq 'Text::Table::Sprintf') {
        require Text::Table::Sprintf;
        return Text::Table::Sprintf::table(
            rows => $rows,
            header_row => $header_row,
            separate_rows => $separate_rows,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        ) . "\n";
    } elsif ($backend eq 'Text::Table::TickitWidget') {
        require Text::Table::TickitWidget;
        return Text::Table::TickitWidget::table(
            rows => $rows,
            header_row => $header_row,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        ) . "\n";
    } elsif ($backend eq 'Text::Table::Tiny') {
        require Text::Table::Tiny;
        return Text::Table::Tiny::table(
            rows => $rows,
            header_row => $header_row,
            separate_rows => $separate_rows,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        ) . "\n";
    } elsif ($backend eq 'Text::Table::TinyBorderStyle') {
        require Text::Table::TinyBorderStyle;
        return Text::Table::TinyBorderStyle::table(
            rows => $rows,
            header_row => $header_row,
            separate_rows => $separate_rows,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        ) . "\n";
    } elsif ($backend eq 'Text::Table::TinyColor') {
        require Text::Table::TinyColor;
        return Text::Table::TinyColor::table(
            rows => $rows,
            header_row => $header_row,
            separate_rows => $separate_rows,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        ) . "\n";
    } elsif ($backend eq 'Text::Table::TinyColorWide') {
        require Text::Table::TinyColorWide;
        return Text::Table::TinyColorWide::table(
            rows => $rows,
            header_row => $header_row,
            separate_rows => $separate_rows,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        ) . "\n";
    } elsif ($backend eq 'Text::Table::TinyWide') {
        require Text::Table::TinyWide;
        return Text::Table::TinyWide::table(
            rows => $rows,
            header_row => $header_row,
            separate_rows => $separate_rows,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        ) . "\n";
    } elsif ($backend eq 'Text::Table::TSV') {
        require Text::Table::TSV;
        return Text::Table::TSV::table(
            rows => $rows,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        );
    } elsif ($backend eq 'Text::Table::XLSX') {
        require Text::Table::XLSX;
        return Text::Table::XLSX::table(
            rows => $rows,
            header_row => $header_row,
            defined($params{backend_opts}) ? %{$params{backend_opts}} : (),
        );
    } elsif ($backend eq 'Text::TabularDisplay') {
        require Text::TabularDisplay;
        my $t = Text::TabularDisplay->new(@{ $rows->[0] });
        $t->add(@{ $rows->[$_] }) for 1..@$rows-1;
        return $t->render . "\n";
    } elsif ($backend eq 'Text::UnicodeBox::Table') {
        require Text::UnicodeBox::Table;
        my $t = Text::UnicodeBox::Table->new;
        if ($header_row) {
            $t->add_header(@{ $rows->[0] });
            $t->add_row(@{ $rows->[$_] }) for 1 .. $#{$rows};
        } else {
            $t->add_header(map {"col$_"} 0..$#{$rows->[0]});
            $t->add_row(@{ $rows->[$_] }) for 0 .. $#{$rows};
        }
        return $t->render;
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
                               backend => 'Text::Table::More');


=head1 DESCRIPTION

This module provides a single function, C<table>, which formats a
two-dimensional array of data as text table, using one of several available
backends. The interface is modelled after L<Text::Table::Tiny> (0.03).
L<Text::Table::Sprintf> is the default backend.

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

Except for the C<backend> parameter, the parameters will mostly be passed to the
backend, sometimes slightly modified if necessary to achieve the desired effect.
If a parameter is not supported by a backend, then it will not be passed to the
backend.

Known parameters:

=over

=item * backend

Optional. Str, default C<Text::Table::Sprintf>. Pick a backend module. Supported
backends:

=over

# CODE: require Text::Table::Any; for (@Text::Table::Any::BACKENDS) { print "=item * $_\n\n" }

=back

Support matrix for each backend:

# CODE: require Text::Table::Any; my $ff; my $rows = [['backend']]; for (sort keys %{ $Text::Table::Any::BACKEND_FEATURES{"Text::Table::Sprintf"} }) { push @$ff, $_; push @{$rows->[0]},$_ } for my $be (sort keys %Text::Table::Any::BACKEND_FEATURES) { push @$rows, [$be, map { $Text::Table::Any::BACKEND_FEATURES{$be}{$_} } @$ff] } my $t = Text::Table::Any::table(header_row=>1, rows=>$rows, backend=>"Text::Table::Tiny"); $t =~ s/^/ /gm; print $t;

=item * rows

Required. Aoaos (array of array-of-scalars). Each element in the array is a row
of data, where each row is an array reference.

=item * header_row

Optional. Bool, default is false. If given a true value, the first row in the
data will be interpreted as a header row, and separated visually from the rest
of the table (e.g. with a ruled line). But some backends won't display
differently.

=item * separate_rows

Boolean. Optional. Default is false. If set to true, will draw a separator line
after each data row.

Not all backends support this.

=item * title

Optional. Str. Title of the table.

Currently the only backends supporting this are C<Text::Table::HTML> and
C<Text::Table::HTML::DataTables>.

=item * backend_opts

Optional. Hashref. Pass backend-specific options to the backend module. Not all
backend modules support this, but all backend modules that have interface
following C<Text::Table::Tiny> should support this. Also note that as the list
of common options is expanded, a previously backend-specific option might be
available later as a common option.

=back

=head2 backends

Return list of supported backends. You can also get the list from the
L</@BACKENDS> package variable.


=head1 VARIABLES

=head2 @BACKENDS

List of supported backends.

=head2 %BACKEND_FEATURES

List of features supported by each backend. Hash key is backend name, e.g.
C<Text::Table::Sprintf>. Hash value is a hashref containing feature name as
hashref key and a boolean value or other value as hashref value to describe the
support of that feature by that backend.


=head1 SEE ALSO

L<Acme::CPANModules::TextTable>

=cut
