namespace :fyber do
  desc "get all the packages from the cran"
  task get_packages: :environment do
    CranWorker.get_packages
  end
end
