require "spec_helper"

module Cran
  describe Repository do
    let(:package_data) { File.read("./spec/support/PACKAGES.txt") }
    let(:parsed_package_data) do
      [
        {
          "Package" => "A3",
          "Version" => "1.0.0",
          "Depends" => "R (>= 2.15.0), xtable, pbapply",
          "Suggests" => "randomForest, e1071",
          "License" => "GPL (>= 2)",
          "NeedsCompilation" => "no"
        },
        {
          "Package" => "abbyyR",
          "Version" => "0.2",
          "Depends" => "R (>= 3.2.0)",
          "Imports" => "httr, XML, curl, RecordLinkage, readr",
          "License" => "GPL (>= 2)",
          "NeedsCompilation"=> "no"
        }
      ]
    end

    describe "#fetch" do
      it "fetches the package data" do
        stub_request(:get, "http://cran.r-project.org/src/contrib/PACKAGES").
          to_return(:body => package_data)

        expect(Repository.fetch).to eq(parsed_package_data)
      end
    end

    describe "#fetch_package_details" do
      let(:package) { parsed_package_data.first }
      let(:package_file) { File.read('./spec/support/A3_1.0.0.tar.gz') }
      let(:parsed_package_details) do
        {
          "Package" => 'A3',
          'Type' => 'Package',
          'Title' => 'Accurate, Adaptable, and Accessible Error Metrics for Predictive Models',
          'Version' => '1.0.0',
          'Date' => '2015-08-15',
          'Author' => 'Scott Fortmann-Roe',
          'Maintainer' => 'Scott Fortmann-Roe <scottfr@berkeley.edu>',
          'Description' => 'Supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.',
          'License' => 'GPL (>= 2)',
          'Depends' => 'R (>= 2.15.0), xtable, pbapply',
          'Suggests' => 'randomForest, e1071',
          'NeedsCompilation' => 'no',
          'Packaged' => '2015-08-16 14:17:33 UTC; scott',
          'Repository' => 'CRAN',
          'Date/Publication' => '2015-08-16 23:05:52'
        }
      end

      it "gets the details from DESCRIPTION inside the tar" do
        stub_request(:get, "http://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz").
          to_return(:body => package_file)

        expect(Repository.fetch_package_details(package)).to eq(parsed_package_details)
      end
    end
  end
end
