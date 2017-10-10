module Fastlane
  module Actions
    module SharedValues
      REMOVE_TAG_CUSTOM_VALUE = :REMOVE_TAG_CUSTOM_VALUE
    end

    class RemoveTagAction < Action
      def self.run(params)
      
      
      # 想根据外界传递过来的参数, 去执行真正的git命令
      # 删除本地标签: git tag -d 标签名称
      # 删除远程标签: git push origin :标签名称
      
      # git status & git add .
      
      # 1. 定义一个空的命令数组
      commonds = []
      
      # 2. 取出参数 tagName , rL, rR
      tagNameR = params[:tagName]
      removeLocal = params[:rL]
      removeRemote = params[:rR]
      

      # 3. 如果是需要删除本地标签 git tag -d 标签名称 >> 追加到 命令数组中
      # 3. 如果是需要删除远程标签 git push origin :标签名称 >> 追加到 命令数组中
      if removeLocal
        commonds << "git tag -d #{tagNameR}"
      end
    
      if removeRemote
        commonds << "git push origin :#{tagNameR}"
      end
      
      
      # 把数组当中所有的命令 按照  & 进行拼接
      resultStr = commonds.join(" & ")
      
      # 执行整个的命令脚本
      Actions.sh(resultStr)
      
      
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "自己定义的actioN, 可以删除本地& 远程标签"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "自己定义的actioN, 可以删除本地& 远程标签......."

      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :tagName,
                                       env_name: "TagName", # The name of the environment variable
                                       description: "需要被删除的标签", # a short description of this parameter
                                       is_string: true,
                                       optional: false
                                       ),
          FastlaneCore::ConfigItem.new(key: :rL,
                             env_name: "REMOVELOCALTAG", # The name of the environment variable
                             description: "是否需要删除本地标签", # a short description of this parameter
                             is_string: false,
                             optional: true,
                             default_value: true
                             ),
        FastlaneCore::ConfigItem.new(key: :rR,
                             env_name: "REMOVEREMOTETAG", # The name of the environment variable
                             description: "是否需要删除远程标签", # a short description of this parameter
                             is_string: false,
                             optional: true,
                             default_value: true
                             )
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['REMOVE_TAG_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        nil
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["sz"]
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
