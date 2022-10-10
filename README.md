# Jekyll-srcset-hook

A Jekyll plugin to add srcset and sizes attributes to images without Liquid tags.

This plugin is intended to be used with media libraries in the cloud like ImageKit.

For example, it will take images in posts written in Markdown:

```
![alt text](https://ik.imagekit.io/your_imagekit_id/image.jpg)
```

And change them to (based on the config in `_config.yml`):

```
<img src="https://ik.imagekit.io/your_imagekit_id/image.jpg" alt="alt text"
     srcset="https://ik.imagekit.io/your_imagekit_id/image.jpg?tr=w-300 300w,
             https://ik.imagekit.io/your_imagekit_id/image.jpg?tr=w-600 600w,
             https://ik.imagekit.io/your_imagekit_id/image.jpg?tr=w-900 900w"
     sizes="(max-width: 300px) 100vw, (max-width: 600px) 50vw, (max-width: 900px) 33vw, 900px"
/>
```

## Installation

Using Bundler, add `gem 'jekyll-srcset-hook'` to the `jekyll_plugins` group in your `Gemfile`:

```
source 'https://rubygems.org'

gem 'jekyll'

group :jekyll_plugins do
  gem 'jekyll-srcset-hook'
end
```

Then run `bundle` to install the gem.

## Configuration

In `_config.yml` add one of the configuration below. By default, `jekyll-srcset-hook` will apply to both posts and pages:

```
jekyll-srcset-hook:
    url_endpoint: https://ik.imagekit.io/your_imagekit_id/
    transformations_widths: ["?tr=w-300 300w", "?tr=w-600 600w", "?tr=w-900 900w"]
    sizes: "(max-width: 300px) 100vw, (max-width: 600px) 50vw, (max-width: 900px) 33vw, 900px"
```

Individual configuration for images in posts and pages can be provided independently using the same URL endpoint:

```
jekyll-srcset-hook:
    url_endpoint: https://ik.imagekit.io/your_imagekit_id/
    posts:
        transformations_widths: ["?tr=w-300 300w", "?tr=w-600 600w", "?tr=w-900 900w"]
        sizes: "(max-width: 300px) 100vw, (max-width: 600px) 50vw, (max-width: 900px) 33vw, 900px"
    pages:
        transformations_widths: ["?tr=w-480 480w", "?tr=w-800 800w"]
        sizes: "(max-width: 600px) 480px, 800px"
```

Or with separate endpoints:

```
jekyll-srcset-hook:
    posts:
        url_endpoint: https://ik.imagekit.io/your_imagekit_id1/
        transformations_widths: ["?tr=w-300 300w", "?tr=w-600 600w", "?tr=w-900 900w"]
        sizes: "(max-width: 300px) 100vw, (max-width: 600px) 50vw, (max-width: 900px) 33vw, 900px"
    pages:
        url_endpoint: https://ik.imagekit.io/your_imagekit_id2/
        transformations_widths: ["?tr=w-480 480w", "?tr=w-800 800w"]
        sizes: "(max-width: 600px) 480px, 800px"
```

## Usage

`jekyll-srcset-hook` will not modify images where the `src` attribute does not begin with the `url_endpoint` value so
it can be used along with existing local images or images from other sources.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/juicy-g/jekyll-srcset-hook. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/jekyll-srcset-hook/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
