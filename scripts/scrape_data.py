import requests


def download_zip_file(url, output_path):
    """
    Downloads a ZIP file from the given URL and saves it to the specified output path.
    """

    try:
        response = requests.get(url)
        response.raise_for_status()

        with open(output_path, "wb") as file:
            file.write(response.content)

        return True

    except requests.exceptions.RequestException as e:
        print(f"Error downloading file: {e}")
        return False

    except Exception as e:
        print(f"An error occurred: {e}")
        return False


def get_url(year):
    """
    Returns the URL of the ZIP file for the given year.
    """
    return f"https://static.nhtsa.gov/nhtsa/downloads/FARS/{year}/National/FARS{year}NationalCSV.zip"


def run():
    """
    Downloads the ZIP file for each year from 1975 to 2023.
    """
    years = range(1975, 2024)

    for year in years:
        url = get_url(year)
        output_path = f"../data/FARS{year}NationalCSV.zip"
        success = download_zip_file(url, output_path)
        if success:
            print(f"Downloaded FARS{year}NationalCSV.zip to {output_path}")
        else:
            print(f"Failed to download FARS{year}NationalCSV.zip")


if __name__ == "__main__":
    run()
