require 'faraday'
require 'faraday_middleware'

module Fastlane
    module Actions
        module SharedValues
            UPLOAD_TO_TTEL_CUSTOM_VALUE = :UPLOAD_TO_TTEL_CUSTOM_VALUE
        end

        class UploadToTtelAction < Action
            def self.run(params)
            # fastlane will take care of reading in the parameter and fetching the environment variable:
            UI.message("The upload_to_ttel action is working.")

            # host, envType, prodType, changeLog
            upload_url = params[:upload_url]
            if upload_url.nil?
              UI.user_error!("You have to provide a upload url")
            end

            envType = params[:envType]
            if envType.nil?
              UI.user_error!("You have to provide the envType")
            end

            prodType = params[:prodType]
            if prodType.nil?
              UI.user_error!("You have to provide the prodType")
            end

            changeLog = params[:changeLog]
            if changeLog.nil?
              changeLog = ''
            end

            build_file = ENV["IPA_OUTPUT_PATH"]
            if build_file.nil?
              UI.user_error!("IPA_OUTPUT_PATH is nil.")
            end

            UI.message("upload_url: #{upload_url}")
            UI.message("envType: #{envType}")
            UI.message("prodType: #{prodType}")
            UI.message("changeLog: #{changeLog}")

            UI.message("build_file: #{build_file}")
            # start upload
            conn_options = {
              request: {
                timeout:       1000,
                open_timeout:  300
              }
            }

            ttel_client = Faraday.new(nil, conn_options) do |c|
              c.request :multipart
              c.request :url_encoded
              c.response :json, content_type: /\bjson$/
              c.adapter :httpclient
              c.ssl.verify = false
            end

            params = {
              'envType' => "#{envType}",
              'prodType' => "#{prodType}",
              'changeLog' => "#{changeLog}",

              'package' => Faraday::UploadIO.new(build_file, 'application/octet-stream')
            }

            UI.message "Start upload #{build_file} to ttel server..."

            response = ttel_client.post upload_url, params

            info = response.body

            if info["code"] == 1
              UI.success "Upload success. "
            else
              UI.user_error!("Upload failed. error info : #{info}")

            end


# sh "shellcommand ./path"

# Actions.lane_context[SharedValues::UPLOAD_TO_TTEL_CUSTOM_VALUE] = "my_val"
end

#####################################################
# @!group Documentation
#####################################################

def self.description
"uploading ipa or apk file to ttel Server, Only use for Ttel project"
end

def self.details
# Optional:
# this is your chance to provide a more detailed description of this action
"uploading ipa or apk file to ttel Server, Only use for Ttel project"
end

def self.available_options
# Define all options your action supports.

# Below a few examples
[
FastlaneCore::ConfigItem.new(key: :upload_url,
                             env_name: "UPLOAD_URL",
                             description: "The url of your upload archive file api, like https://172.16.32.23/app/upload",
                             is_string: true, # true: verifies the input is a string, false: every kind of value
                             default_value: ''), # the default value if the user didn't provide one

FastlaneCore::ConfigItem.new(key: :envType,
                             env_name: "ENV_TYPE",
                             description: "envType",
                             is_string: true, # true: verifies the input is a string, false: every kind of value
                             default_value: ''), # the default value if the user didn't provide one

#  host, envType, prodType, changeLog
FastlaneCore::ConfigItem.new(key: :prodType,
                             env_name: "PROD_TYPE",
                             description: "prodType",
                             is_string: true, # true: verifies the input is a string, false: every kind of value
                             default_value: ''), # the default value if the user didn't provide one

FastlaneCore::ConfigItem.new(key: :changeLog,
                             env_name: "CHANGE_LOG",
                             description: "changeLog",
                             is_string: true, # true: verifies the input is a string, false: every kind of value
                             default_value: '') # the default value if the user didn't provide one

]
end

def self.output
# Define the shared values you are going to provide
# Example
[
['UPLOAD_TO_TTEL_CUSTOM_VALUE', 'A description of what this value contains']
]
end

def self.return_value
# If you method provides a return value, you can describe here what it does
end

def self.authors
# So no one will ever forget your contribution to fastlane :) You are awesome btw!
["https://github.com/pandaApe"]
end

def self.is_supported?(platform)
# you can do things like
#
#  true
#
#  platform == :ios
#
#  [:ios, :mac].include?(platform)
#

platform == :ios
end
end
end
end
