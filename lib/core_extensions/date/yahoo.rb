module CoreExtensions
  module Date
    module Yahoo
      def yahoo_format
        d = (day < 10) ? ('0' + day.to_s) : day.to_s
        m = (month < 10) ? ('0' + month.to_s) : month.to_s
        "#{year}-#{m}-#{d}"
      end
    end
  end
end