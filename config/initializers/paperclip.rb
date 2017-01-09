# frozen_string_literal: true

module Paperclip
  class Attachment
    class InsecureUrlError < StandardError; end
    INSECURE_URL_ERROR = "Use \`expiring_url\` instead of \`url\`.  "\
      "In production, attachments are stored on S3 and are not accessible "\
      "to the public except through expiring URL's. For example, "\
      "\`expiring_url(10, default_style)\` returns a URL that is valid for "\
      "only 10 seconds, just long enough for it to open in the browser."

    # When using S3 storage (i.e. production), `url` and `expiring_url` are overridden
    # by the `Paperclip::Storage::S3` module, and `url` will fail because files are
    # not publicly readable.
    # We need to make sure it also fails in development and test.
    def url(_style_name = default_style, _options = {})
      raise InsecureUrlError, INSECURE_URL_ERROR
    end

    # The original `expiring_url` (when not overridden by `Paperclip::Storage::S3`)
    # is just a passthru to `url`, so we copy the implementation straight here since
    # we've changed the implementation of `url`.
    def expiring_url(_time = 3600, style_name = default_style)
      @url_generator.for(style_name, default_options)
    end

    default_options[:path].gsub!(/:url/, default_options.fetch(:url))
  end
end
