module BootstrapMarkdown
	module Generators

		class InstallGenerator < Rails::Generators::Base
			source_root File.expand_path("../templates", __FILE__)
			desc "This generator installs Bootstrap-markdown to Asset Pipeline"
			argument :stylesheets_type, :type => :string, :default => 'static', :banner => 'sass, less or static(default)'

			def add_assets
				add_javascripts
				add_stylesheets
			end


			# def add_assets
			# 	js_manifest = 'app/assets/javascripts/application.js'
			# 	css_manifest = 'app/assets/stylesheets/application.css'
			# 	if File.exist?(js_manifest)
			# 		insert_into_file js_manifest, "//= require bootstrap-markdown\n", :after => "twitter/bootstrap\n"
			# 	else
			# 		copy_file "application.js", js_manifest
			# 	end

			# 	if File.exist?(css_manifest)
			# 		if use_sass?
			# 			copy_file "bootstrap-markdown-overide.css.scss", "app/assets/stylesheets/bootstrap-markdown-overide.css.scss"
			# 			content = File.read(css_manifest)
			# 			unless content.match(/require_tree\s+\.\s*$/)
			# 				style_require_block = " *= require bootstrap-markdown-overide\n"
			# 				insert_into_file css_manifest, style_require_block, :after => "require_self\n"
			# 			end
			# 		else
			# 			insert_into_file css_manifest, " *= require bootstrap-markdown-static/bootstrap-markdown.min\n", :after => "require_self\n"
			# 		end
			# 	else
			# 		copy_file "application.css", "app/assets/stylesheets/application.css"
			# 	end
			# end

			private

			def js_manifest
				'app/assets/javascripts/application.js'
			end

			def css_manifest
				'app/assets/stylesheets/application.css'
			end

			def manifest_exist? path
				File.exist?(path)
			end

			def found_require_tree?
				content = File.read(css_manifest)
				content.match(/require_tree\s+\.\s*$/)
			end

			def use_sass?
				(defined?(Sass) && (stylesheets_type!='static' && stylesheets_type!="less")) || (stylesheets_type=='sass')
			end

			def user_less?
				(defined?(Less) && ( stylesheets_type!='static' && stylesheets_type!='sass')) || (stylesheets_type=='less')
			end

			def copy_stylesheet_template
				copy_file "#{stylesheets_template}", "app/assets/stylesheets/#{stylesheets_template}"
			end

			def rewrite_manifest
				insert_into_file css_manifest, " *= require static/bootstrap-markdown.min\n", :after => "require_self\n"
			end

			def append_stylesheet_templete
				style_require_block = " *= require bootstrap-markdown-overide\n"
				insert_into_file css_manifest, style_require_block, :after => "require_self\n"
			end

			def stylesheets_template
				case stylesheets_type
				when 'sass'
					"bootstrap-markdown-overide.css.scss"
				when 'less'
					"bootstrap-markdown-overide.css.less"
				else
					raise StandardError.new("Not yet supported")
				end
			end

			def add_javascripts 
				if manifest_exist? js_manifest
					insert_into_file js_manifest, "//= require bootstrap-markdown\n", :after => "twitter/bootstrap\n"
				else
					copy_file "application.js", js_manifest
				end
			end

			def add_stylesheets
				if manifest_exist?(css_manifest)
					copy_stylesheet_template if use_sass? || user_less?
					rewrite_manifest unless use_sass? || user_less?
					append_stylesheet_templete unless found_require_tree?
				else
					copy_file "application.css", css_manifest
					copy_stylesheet_template if use_sass? || user_less?
					rewrite_manifest unless use_sass? || user_less?
				end
			end

		end

	end
end