```shell
cd {npm_module_dir}
npm list -g --depth=0
npm link

npm list -g --depth=0
cd {project_dir}
npm link {npm_module_name} 

cd {npm_module_dir} && npm unlink -g
npm uninstall -g sat20-extension
```