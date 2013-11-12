module.exports = function(config) {
  config.set({
    frameworks: ["jasmine"],

    basePath: '../',
    files: [
      // cdn/vendor files
        'vendor/assets/javascripts/jquery-2.0.3.min.js',
        'vendor/assets/javascripts/angular/angular.min.js',
        'vendor/assets/javascripts/angular/angular-*.min.js',
      // app
        'app/assets/javascripts/angular_initialize.js.coffee',
        'app/assets/javascripts/app/**/*.js.coffee',
        'app/assets/javascripts/vendor/*.js',
      // tests
        'spec/javascripts/lib/angular/angular-mocks.js',
        'spec/javascripts/unit/**/*.js.coffee'
    ],

    autoWatch: false,
    singleRun: true,
    browsers: ['Chrome'],
    reporters: ['dots'],

    preprocessors: {
      '**/*.coffee': 'coffee'
    }
  });
};