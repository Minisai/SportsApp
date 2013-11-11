module.exports = function(config) {
  config.set({
    frameworks: ["jasmine"],

    basePath: '../',
    files: [
      // cdn/vendor files
        'vendor/assets/javascripts/jquery-2.0.3.min.js',
        'vendor/assets/javascripts/angular/angular.min.js',
      // app
        'app/assets/javascripts/app/**/*.js',
      // tests
        'spec/javascripts/lib/angular/angular-mocks.js',
        'spec/javascripts/unit/**/*.js'
    ],

    autoWatch: false,
    singleRun: true,
    browsers: ['Chrome'],
    reporters: ['dots', 'junit'],

    preprocessors: {
      '**/*.coffee': 'coffee'
    }
  });
};