'use strict';

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    cssmin: {
      combine: {
        files: {
          '_includes/style.css': ['css/main.css', 'css/syntax.css'],
          '_includes/projects.css': ['css/projects.css']
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-cssmin');

  grunt.registerTask('default', ['cssmin']);

};
