class CranWorker
  class << self
    def get_packages
      list = Cran::Repository.fetch.first(50)

      list.each do |package|
        self.get_package(package)
      end
    end
    handle_asynchronously :get_packages

    def get_package(package)
      details = Cran::Repository.fetch_package_details(package)

      Package.create(
        name: details['Package'],
        version: details['Version'],
        title: details['Title']
      )
    end
    handle_asynchronously :get_package
  end
end
