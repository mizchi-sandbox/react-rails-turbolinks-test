gulp   = require 'gulp'
shell  = require 'gulp-shell'
coffee = require 'gulp-coffee'
babel  = require 'gulp-babel'
jade   = require '@mizchi/gulp-react-jade'
rename = require 'gulp-rename'
watchify = require 'gulp-watchify'
plumber = require 'gulp-plumber'

gulp.task 'default', ['watch']
gulp.task 'init', shell.task [
  'rm -r lib'
  'rm -r node_modules'
  'npm install'
]

gulp.task 'build:coffee', ->
  gulp.src('src/**/*.coffee')
    .pipe(plumber())
    .pipe(coffee())
    .pipe(gulp.dest('lib'))

gulp.task 'build:js', ->
  gulp.src('src/**/*.js')
    .pipe(plumber())
    .pipe(babel())
    .pipe(gulp.dest('lib'))

gulp.task 'build:jade', ->
  gulp.src('src/**/*.jade')
    .pipe(plumber())
    .pipe jade()
    .pipe(gulp.dest('lib'))

watching = false
gulp.task 'enable-watch-mode', -> watching = true
gulp.task 'browserify:application', watchify (watchify) ->
  gulp.src 'lib/application.js'
    .pipe watchify
      watch: watching
    .pipe rename('bundle.js')
    .pipe gulp.dest '../app/assets/javascripts'

gulp.task 'browserify:components', watchify (watchify) ->
  gulp.src 'lib/components.js'
    .pipe watchify
      watch: watching
    .pipe rename('components.js')
    .pipe gulp.dest '../app/assets/javascripts'

gulp.task 'watch', [
  'build'
  'enable-watch-mode'
  'browserify:application'
  'browserify:components'
], ->
  gulp.watch 'src/**/*.coffee', ['build:coffee']
  gulp.watch 'src/**/*.js', ['build:js']
  gulp.watch 'src/**/*.jade', ['build:jade']
  gulp.watch 'src/styles/**/*.scss', ['build:css']

gulp.task 'build', [
  'build:coffee'
  'build:js'
  'build:jade'
]
