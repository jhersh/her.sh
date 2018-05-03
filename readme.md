# her dot sh

[![Circle CI](https://circleci.com/gh/jhersh/her.sh.svg?style=svg&circle-token=b14375d9acfaff56b8d07ee03b0fae207b874efa)](https://circleci.com/gh/jhersh/her.sh)

Source for [her.sh](https://her.sh).

### Architecture

her.sh is a static site...

- Generated by [Jekyll](http://jekyllrb.com/)
- Hosted on [Amazon S3](https://aws.amazon.com/s3/) and [Amazon Cloudfront](https://aws.amazon.com/cloudfront/) for great uptime and incredibly low cost
- With a free SSL certificate from [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/) for HTTPS


### Running Locally

It's super easy to build the site and test it locally:

```
rake setup
rake serve
```

### Publishing

`rake publish` automates the entire deployment process:

1. Generate the site with Jekyll.
2. GZip HTML files, which can be served compressed directly from S3 for stupendously fast page load times.
3. Upload GZip'd files to S3.
4. Upload remaining files (images, CSS, JS) to S3.
5. There is no step 5.

Files are uploaded to S3 using [s3cmd](http://s3tools.org/s3cmd), a handy command-line tool for S3.

### Thanks!

her.sh is a [@jhersh](https://github.com/jhersh) production -- ([electronic mail](mailto:jon@her.sh))
